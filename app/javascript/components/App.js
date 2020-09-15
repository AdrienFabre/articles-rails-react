import React from "react"
import Card from "./Card/index.js"
import axios from "axios"
import "./styles.css"

class App extends React.Component {
  constructor() {
    super()
    this.state = {
      articles: null,
      loading: true,
    }
  }

  componentDidMount() {
    axios
      .get("/api/v1/articles.json")
      .then((resp) => {
        let articles = resp.data
        console.log(resp.data)
        this.setState({ articles: articles, loading: false })
        console.log(this.state.articles)
      })
      .catch((resp) => console.log(resp))
  }

  addLike = (article_id) => {
    this.setState({ loading: true })
    let { articles } = this.state
    let updatedArticles = [...articles]
    axios
      .patch(`/api/v1/articles/${article_id}`)
      .then((resp) => {
        updatedArticles.map((article) => {
          if (article.id === article_id) {
            article.likes = resp.data.likes
          }
        })
        console.log("updatedArticles", updatedArticles)
        this.setState({ articles: updatedArticles, loading: false })
      })
      .catch((resp) => console.log(resp))
  }

  render() {
    const { articles, loading } = this.state
    console.log("Render Articles", articles)
    console.log("Render Loading", loading)
    return (
      <div className="wrapper">
        <div className="header">Amazing App</div>
        {loading ? (
          <div className="loading"> Loading </div>
        ) : (
          <div>
            {articles.map((article) => (
              <Card
                className="card"
                article={article}
                key={article.id}
                addLike={this.addLike}
              />
            ))}
          </div>
        )}
      </div>
    )
  }
}

export default App
