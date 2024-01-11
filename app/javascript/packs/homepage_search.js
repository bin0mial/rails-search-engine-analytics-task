class HomepageSearch {
    #query;

    static #timeout;
    static #previousQuery;
    static #selectors = {
        loader: "homeSearchLoader",
        resultSet: "resultSet",
        results: "results",
        input: 'query',
        form: 'searchArticlesForm'
    }

    static searchQueryHandler(event){
        if(HomepageSearch.#timeout){
            clearTimeout(HomepageSearch.#timeout);
        }
        HomepageSearch.#timeout = setTimeout(() => {
            new HomepageSearch(event.target.value).handleSearchQuery();
        }, 800)
    }

    constructor(query) {
        this.#query = query;
    }

    // Instance methods
    async handleSearchQuery(){
        this.#setLoading();
        this.#clearResultSet();
        this.#sanitizeQuery();
        if (this.#shouldFire()) {
            const result = await this.#fireSearchQuery();
            this.#handleSearchResult(result);
        }
        this.#unsetLoading();
    }


    // Private methods
    #setLoading() {
        const loader = this.#getLoaderElement();
        loader.classList.remove('d-none');
        loader.classList.add('d-flex');

        this.#hideResultSet();
    }

    #unsetLoading() {
        const loader = this.#getLoaderElement();
        loader.classList.add('d-none');
        loader.classList.remove('d-flex');

        this.#showResultSet();
    }

    #handleSearchResult(result) {
        HomepageSearch.#previousQuery = this.#query;
        const resultSetElement = this.#getResultSetElement();
        if(!result.length){
            this.#clearResultSet();
            resultSetElement.innerText = 'No result found.';
        }
        const url = this.#getFormElement().getAttribute('action').replace('.json', '');
        const listElement = document.createElement('ul')
        result.forEach((resultItem) => {
            const listItem = document.createElement('li');
            const anchorItem = document.createElement('a');
            anchorItem.setAttribute('href', `${url}/${resultItem.id}`)
            anchorItem.innerText = resultItem.title;
            listItem.appendChild(anchorItem);
            listElement.appendChild(listItem);
        })
        resultSetElement.appendChild(listElement);
    }

    async #fireSearchQuery () {
        const url = this.#getFormElement().getAttribute('action');
        const result =  await fetch(`${url}?` + new URLSearchParams({
            'q[m]': 'or',
            'q[title_cont]': this.#query,
            'q[body_cont]': this.#query
        }), {
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": this.#getCsrfToken()
            }
        })
        return result.json();
    }

    #sanitizeQuery = () => {
        this.#query = this.#query.trim();
        // remove more than 1 space between words
        this.#query = this.#query.replace(/\s{2,}/g, ' ');
    }

    #shouldFire = () => {
        return this.#query && this.#query !== HomepageSearch.#previousQuery;
    }

    #clearResultSet() {
        this.#getResultSetElement().innerHTML = '';
    }

    #getElementById(id){
        return document.getElementById(id);
    }

    #getLoaderElement(){
        return this.#getElementById(HomepageSearch.#selectors.loader)
    }

    #getResultsElement(){
        return this.#getElementById(HomepageSearch.#selectors.results)
    }

    #getResultSetElement(){
        return this.#getElementById(HomepageSearch.#selectors.resultSet)
    }

    #getFormElement() {
        return this.#getElementById(HomepageSearch.#selectors.form)
    }

    #showResultSet() {
        const result = this.#getResultsElement();

        result.classList.remove('d-none')
        result.classList.add('d-block')
    }

    #hideResultSet() {
        const result = this.#getResultsElement();

        result.classList.add('d-none')
        result.classList.remove('d-block')
    }

    #getCsrfToken() {
        return document.querySelector("meta[name='csrf-token']").getAttribute("content")
    }
}

const initHomepage = () => {
    const element = document.getElementById('query');
    element.addEventListener('input', HomepageSearch.searchQueryHandler);
}

document.addEventListener("DOMContentLoaded", initHomepage);