
document.querySelector(".search-wrapper").addEventListener("submit", (e) => {
  e.preventDefault();
  createNewQuery();
     
});
const createNewQuery = async () => {
  const inputElement = document.querySelector("#search");
  const query = inputElement.value;

  if (query.length > 0) {
    try {
      const response = await fetch("/searches", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ query }),
      });

      const data = await response.json();
      console.log(data);
      return data;
    } catch (error) {
      return error;
    }
  }
};

// Get search results

  getQueries = async () => {
    try {
      const response = await fetch("/searches", {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },

      });
      const data = await response.json();
      console.log(data);
      return data;
    } catch (error) {
      return error;
    }
  }

  displayResults = () => {
    // let result = '';
    getQueries().then((data) => {
      console.log(data);
      // data.forEach((item) => {
      //   result += `<li>${item.query}</li>`
      //   document.getElementById("search-results").innerHTML = result;

      //})
    })
  }