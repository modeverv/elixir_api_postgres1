defmodule ApiWeb.PostController do
  use ApiWeb, :controller

  alias Api.Tool
  alias Api.Tool.Post

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    post = Tool.list_post()
    render(conn, "index.json", post: post)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Tool.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Tool.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Tool.get_post!(id)

    with {:ok, %Post{} = post} <- Tool.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Tool.get_post!(id)
    with {:ok, %Post{}} <- Tool.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
