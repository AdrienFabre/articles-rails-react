describe("The Home Page", () => {
  it("successfully loads", () => {
    cy.visit("http://localhost:3000")
  })

  it("contains Sharing App", () => {
    cy.get("h1").should("have.text", "Sharing App")
  })

  it("contains api response text", () => {
    cy.get(".title")
      .last()
      .should("have.text", "Small flower vase and ceramic plant pot")
    cy.get(".owner").last().should("have.text", "Posted by Fiorella")
    cy.get(".description")
      .last()
      .should("have.text", "Used, in need of a whipe")
  })

  it("contains the clear image", () => {
    cy.get('[alt="image-clear"]')
      .should("be.visible")
      .and(($img) => {
        expect($img[0].naturalWidth).to.be.greaterThan(0)
      })
  })

  it("contains the blur image", () => {
    cy.get('[alt="image-blur"]')
      .should("be.visible")
      .and(($img) => {
        expect($img[0].naturalWidth).to.be.greaterThan(0)
      })
  })

  it("contains the avatar image", () => {
    cy.get('[alt="avatar"]')
      .should("be.visible")
      .and(($img) => {
        expect($img[0].naturalWidth).to.be.greaterThan(0)
      })
  })

  it("contains the like button", () => {
    cy.get(".button").last().should("not.be.disabled")
  })
})
