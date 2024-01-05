document.getElementById("search-box").addEventListener("input", function() {
    const query = this.value;
    if (query.length >= 3) {
      $.ajax({
        url: "/searches",
        method: "POST",
        data: { query: query },
        success: function(response) {
          $("#search-results").html(response);
        }
      });
    } else {
      $("#search-results").html("");
    }
  });