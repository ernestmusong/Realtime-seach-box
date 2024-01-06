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
        displayResults(result.articles);
      },
      error: (error) => {
        console.log(error)
      }
    })
  }
  
  displayResults = (articles) => {
    const resultsDom = document.querySelector('#search-results')
    resultsDom.innerHTML = '';
    if(articles.length === 0) {
        const noResultDiv = document.createElement('p') 
        noResultDiv.textContent = 'No results found' 
        resultsDom.appendChild(noResultDiv)
    } else {
        articles.forEach((article) => {
            const articlesList = document.createElement('ul')
            articlesList.className = 'article';
            articlesList.innerHTML = `<li>${article.title}</li>`
            resultsDom.appendChild(articlesList)
        })
    }
    
  }