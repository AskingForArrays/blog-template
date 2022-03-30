﻿using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace blog_template.Data.Domain
{
    public partial class Users
    {
        public Users()
        {
            Blog = new HashSet<Blog>();
            Comments = new HashSet<Comments>();
        }

        public int UserId { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string AccessLevel { get; set; }

        public virtual ICollection<Blog> Blog { get; set; }
        public virtual ICollection<Comments> Comments { get; set; }
    }
}
