﻿using System;
using Caching;
using NUnit.Framework;

namespace UnitTests
{
    [TestFixture]
    public class when_having_blog_with_posts : FixtureBase
    {
        private Blog blog;

        protected override void Context()
        {
            Console.WriteLine("--------------Start setup context");
            base.Context();
            blog = new Blog{ Author = "Gabriel", Name = "Keep on running"};
            blog.Posts.Add(new Post{Title = "First post", Body = "Some text"});
            blog.Posts.Add(new Post { Title = "Second post", Body = "Some other text" });
            blog.Posts.Add(new Post { Title = "Third post", Body = "Third post text" });
            using (var session = SessionFactory.OpenSession())
            using(var tx = session.BeginTransaction())
            {
                session.Save(blog);
                tx.Commit();        // important otherwise caching does NOT work!
            }

            Console.WriteLine("--------------End setup context");
        }

        protected override string ConfigurationName
        { get { return "hibernate.2nd.cfg.xml"; }}

        [Test]
        public void try_load_blog_with_posts()
        {
            Console.WriteLine(">>>>First load...");
            using (var session = SessionFactory.OpenSession())
            {
                var blog1 = session.Get<Blog>(blog.Id);
                Console.WriteLine(">>>>>>>>Iterating posts...");
                foreach (var post in blog1.Posts)
                    Console.WriteLine("{0} - {1}", post.Id, post.Title);
            }
            Console.WriteLine(">>>>Second load...");
            using(var session = SessionFactory.OpenSession())
            {
                var blog2 = session.Get<Blog>(blog.Id);
                Console.WriteLine(">>>>>>>>Iterating posts...");
                foreach (var post in blog2.Posts)
                    Console.WriteLine(post.Id);
            }
            Console.WriteLine(">>>>Third load...");
            using (var session = SessionFactory.OpenSession())
            {
                var blog3 = session.Get<Blog>(blog.Id);
                Console.WriteLine(">>>>>>>>Iterating posts...");
                foreach (var post in blog3.Posts)
                    Console.WriteLine("{0} - {1}", post.Id, post.Title);
            }
            
        }

        [Test]
        public void trying_to_cache_a_query()
        {
            using (var session = SessionFactory.OpenSession())
            {
                Console.WriteLine("---> using query first time");
                var query = session
                    .CreateQuery("from Blog b where b.Author = :author")
                    .SetString("author", "Gabriel")
                    .SetCacheable(true);
                var list = query.List<Blog>();
            }
            using (var session = SessionFactory.OpenSession())
            {
                Console.WriteLine("---> using query second time");
                var query2 = session
                    .CreateQuery("from Blog b where b.Author = :author")
                    .SetString("author", "Gabriel")
                    .SetCacheable(true);
                var list2 = query2.List<Blog>();
            }
        }

        [Test]
        public void trying_to_cache_a_complex_query()
        {
            using (var session = SessionFactory.OpenSession())
            {
                Console.WriteLine("---> using query first time");
                var list = session
                    .CreateQuery("select b from Blog b join fetch b.Posts p where p.Body like :body")
                    .SetString("body", "Some%")
                    .SetCacheable(true)
                    .List<Blog>();
            }
            using (var session = SessionFactory.OpenSession())
            {
                Console.WriteLine("---> using query second time");
                var list = session
                    .CreateQuery("select b from Blog b join fetch b.Posts p where p.Body like :body")
                    .SetString("body", "Some%")
                    .SetCacheable(true)
                    .List<Blog>();
            }
        }

        [Test]
        public void trying_named_query()
        {
            using (var session = SessionFactory.OpenSession())
            {
                Console.WriteLine("---> using named query first time");
                var list = session.GetNamedQuery("query1")
                    .SetString("name", "Keep%")
                    .List<Blog>();
            }
            using (var session = SessionFactory.OpenSession())
            {
                Console.WriteLine("---> using named query second time");
                var list2 = session.GetNamedQuery("query1")
                    .SetString("name", "Keep%")
                    .List<Blog>();
            }
        }

        [Test]
        public void trying_to_clear_a_cache_region()
        {
            SessionFactory.EvictQueries("My Region");
        }
    }
}
