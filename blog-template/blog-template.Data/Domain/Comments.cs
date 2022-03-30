using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace blog_template.Data.Domain
{
    public partial class Comments
    {
        public int CommentId { get; set; }
        public DateTime Date { get; set; }
        public int UserName { get; set; }
        public string Textbox { get; set; }
        public int BlogId { get; set; }

        public virtual Blog Blog { get; set; }
        public virtual Users UserNameNavigation { get; set; }
    }
}
