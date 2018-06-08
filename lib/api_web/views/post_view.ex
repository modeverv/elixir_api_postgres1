defmodule ApiWeb.PostView do
  use ApiWeb, :view
  alias ApiWeb.PostView

  def render("index.json", %{post: post}) do
    %{data: render_many(post, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      body: post.body}
  end
end
