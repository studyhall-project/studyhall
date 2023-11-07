defmodule StudyHallWeb.PageControllerTest do
  use StudyHallWeb.ConnCase

  test "GET /", ~M{conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end
end
