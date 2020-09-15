import React from "react"
import "./styles"

class Card extends React.Component {
  render() {
    let article = this.props.article
    let date = new Date(article.last_listed).toString().slice(0, 24)

    return (
      <div className="card">
        <div className="title">{article.title}</div>
        <div>{article.description}</div>
        <button
          className="button"
          onClick={() => this.props.addLike(article.id)}
        >
          <div className="likes">
            LIKE
            <br />
            {article.likes}
          </div>
        </button>
        <img className="image" src={`${article.image}`} alt="new" />
        <div>
          {article.user} - {date}
        </div>
      </div>
    )
  }
}

export default Card
