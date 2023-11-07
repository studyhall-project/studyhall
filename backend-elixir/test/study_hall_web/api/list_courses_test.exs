defmodule StudyHallWeb.Api.ListCoursesTest do
  use StudyHallWeb.ConnCase

  alias StudyHall.CourseCatalog.Course

  @list_courses_query """
  query {
    listCourses {
      id
      title
    }
  }
  """

  test "query: listCourses", ~M{conn} do
    Course.create!(%{title: "Course Apple"})
    Course.create!(%{title: "Course Banana"})
    Course.create!(%{title: "Course Cherry"})

    conn =
      post(conn, "/gql", %{
        "query" => @list_courses_query,
        "variables" => %{}
      })

    assert response = json_response(conn, 200)

    assert %{
             "data" => %{
               "listCourses" => [
                 %{"id" => _, "title" => "Course Apple"},
                 %{"id" => _, "title" => "Course Banana"},
                 %{"id" => _, "title" => "Course Cherry"}
               ]
             }
           } = response
  end

  @get_course_query """
  query getCourse($id: ID!) {
    getCourse(id: $id) {
      id
      title
    }
  }
  """

  test "query: getCourse", ~M{conn} do
    %Course{id: course_id} = Course.create!(%{title: "Course Apple"})

    conn =
      post(conn, "/gql", %{
        "query" => @get_course_query,
        "variables" => %{"id" => course_id}
      })

    assert response = json_response(conn, 200)

    assert %{
             "data" => %{
               "getCourse" => %{
                 "id" => ^course_id,
                 "title" => "Course Apple"
               }
             }
           } = response
  end
end
