﻿using System;
using System.Collections.Generic;

#nullable disable

namespace EFPractice_Day11.Models
{
    public partial class ContactType
    {
        public ContactType()
        {
            BusinessEntityContacts = new HashSet<BusinessEntityContact>();
        }

        public int ContactTypeId { get; set; }
        public string Name { get; set; }
        public DateTime ModifiedDate { get; set; }

        public virtual ICollection<BusinessEntityContact> BusinessEntityContacts { get; set; }
    }
}
