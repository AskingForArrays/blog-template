using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace blog_template.Data.Domain
{
    public partial class Blog
    {
        public Blog()
        {
            Comments = new HashSet<Comments>();
        }

        public int BlogId { get; set; }
        public string Title { get; set; }
        public DateTime Date { get; set; }
        public int UserId { get; set; }
        public string Textbox { get; set; }
        public string Picture1 { get; set; }
        public string Picture2 { get; set; }
        public string Picture3 { get; set; }
        public string Picture4 { get; set; }

        public virtual Users User { get; set; }
        public virtual ICollection<Comments> Comments { get; set; }
    }
}
