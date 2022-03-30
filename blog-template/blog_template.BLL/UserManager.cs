using blog_template.Data.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace blog_template.BLL
{
    public class UserManager
    {

        public static bool checkUser(User user)
        {
            bool notexist = false;
            var context = new BlogTemplateContext();
            var withSameUsername = context.User.SingleOrDefault(u => u.Username == user.Username);
            if (withSameUsername == null)
                notexist = true;
            return notexist;
        }

        public static void Add(User user)
        {
            var context = new BlogTemplateContext();
            context.User.Add(user);
            context.SaveChanges();
        }

        /// <summary>
        /// User is authenticated based on credentials and a user returned if exists or null if not.
        /// </summary>
        /// <param name="username">Username as string</param>
        /// <param name="password">Password as string</param>
        /// <returns>A user object or null.</returns>
        public static User Authenticate(string username, string password)
        {
            var context = new BlogTemplateContext();
            var user = context.User.SingleOrDefault(usr => usr.Username == username
                                                    && usr.Password == password);
            return user; //this will either be null or an object
        }

    }
}
