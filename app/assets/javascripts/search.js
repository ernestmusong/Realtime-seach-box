//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require_tree

handleSearch = (query) => {
    $.ajax({
      url: '/searches',
      method: 'POST',
      data: {query: query},
      success: (result) => {
        console.log(result)
        displayResults(result.suggestions);
      },
      error: (error) => {
        console.log(error)
      }
    })
  }


 
  displayResults = (results) => {
    const resultsDom = document.querySelector('#search-results')
    resultsDom.innerHTML = '';
    if(results.length === 0) {
        const noResultDiv = document.createElement('p') 
        noResultDiv.textContent = 'No results found' 
        resultsDom.appendChild(noResultDiv)
    } else {
        results.forEach((result) => {
            const articlesList = document.createElement('ul')
            articlesList.className = 'results';
            articlesList.innerHTML = `<li>${result}</li>`
            resultsDom.appendChild(articlesList)
        })
    }
    
  }


   