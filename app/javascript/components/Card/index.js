import React from "react"
import "./styles"
import axios from "axios"

import JavascriptTimeAgo from "javascript-time-ago"
import en from "javascript-time-ago/locale/en"
JavascriptTimeAgo.addLocale(en)
import ReactTimeAgo from "react-time-ago"

class Card extends React.Component {
  constructor() {
    super()
    this.state = {
      article: null,
    }
  }

  addLike = (article) => {
    this.setState({ loading: true })
    let updatedArticle = { ...article }

    const csrfToken = document.querySelector("[name=csrf-token]").content
    axios.defaults.headers.common["X-CSRF-TOKEN"] = csrfToken

    axios
      .patch(`/api/v1/articles/${article.id}`)
      .then((resp) => {
        updatedArticle.likes = resp.data.data.likes
        this.setState({ article: updatedArticle })
      })
      .catch((resp) => console.log(resp))
  }

  render() {
    let article = this.state.article || this.props.article
    let date = new Date(article.updated_at)

    return (
      <div className="card">
        <img
          className="blur-background"
          src={`${article.image}`}
          alt="blurBackground"
        />
        <img className="image" src={`${article.image}`} alt="image" />
        <div className="user">
          <img
            className="user-avatar"
            src={`${article.user_avatar}`}
            alt="new"
          />
          <div className="details">
            Posted by {article.user} - <ReactTimeAgo date={date} />
          </div>
          <button className="button" onClick={() => this.addLike(article)}>
            <div className="likes">
              <span className="heart"></span> {article.likes}{" "}
              {article.likes > 1 ? "likes" : "like"}
            </div>
          </button>
        </div>
        <div className="title">{article.title}</div>
        <div className="description">{article.description}</div>
      </div>
    )
  }
}

export default Card
