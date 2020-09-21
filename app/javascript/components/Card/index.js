import React from "react"
import axios from "axios"
import "./styles"

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
        updatedArticle.likes = resp.data.likes
        this.setState({ article: updatedArticle })
      })
      .catch((resp) => console.log(resp))
  }

  renderImage = (image) => {
    return (
      <>
        <img className="image-blur" src={`${image}`} alt="image-blur" />
        <img className="image-clear" src={`${image}`} alt="image-clear" />
      </>
    )
  }

  renderLikes = (likes) => {
    return (
      <div className="likes">
        <span className="heart" /> {likes} {likes > 1 ? "likes" : "like"}
      </div>
    )
  }

  render() {
    let article = this.state.article || this.props.article
    let date = new Date(article.updated_at)

    return (
      <div className="card">
        {this.renderImage(article.image)}
        <div className="middle-layer">
          <img className="avatar" src={`${article.user_avatar}`} alt="avatar" />
          <div className="info">
            <span className="owner">Posted by {article.user}</span> -{" "}
            <ReactTimeAgo date={date} />
          </div>
          <button className="button" onClick={() => this.addLike(article)}>
            {this.renderLikes(article.likes)}
          </button>
        </div>
        <div className="title">{article.title}</div>
        <div className="info description">{article.description}</div>
      </div>
    )
  }
}

export default Card
