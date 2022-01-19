using System;
using System.Collections.Generic;



namespace ZomatoApp.Models
{
    public partial class Quote
    {
        public int QuoteId { get; set; }
        public decimal? QuoteSubtotal { get; set; }
        public decimal? ShippmentTax { get; set; }
        public decimal? QuoteFinalTotal { get; set; }
        public decimal? QuoteDiscount { get; set; }
        public string ShippmentName { get; set; }
    }
}
