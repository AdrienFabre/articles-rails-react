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
        let articles = resp.data.data
        console.log(resp.data)
        this.setState({ articles: articles, loading: false })
        console.log(this.state.articles)
      })
      .catch((resp) => console.log(resp))
  }

  render() {
    const { articles, loading } = this.state
    console.log("Render Articles", articles)
    console.log("Render Loading", loading)
    return (
      <>
        <div className="wrapper">
          <div className="content">
            <div className="header">Sharing App</div>

            {loading ? (
              <div className="loader"> </div>
            ) : (
              <div>
                {articles.map((article) => (
                  <Card article={article} key={article.id} />
                ))}
              </div>
            )}
          </div>
        </div>
      </>
    )
  }
}

export default App
