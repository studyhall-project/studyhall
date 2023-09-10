defmodule StudyHallWeb.ErrorJSONTest do
  use StudyHallWeb.ConnCase, async: true

  test "renders 404" do
    assert StudyHallWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert StudyHallWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
