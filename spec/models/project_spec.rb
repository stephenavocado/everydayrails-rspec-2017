require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "Joe",
      last_name:  "Tester",
      email:      "joetester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )

    user.projects.create(
      name: "Test Project",
    )

    new_project = user.projects.build(
      name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows users to share a project name" do
    user_1 = User.create(
      first_name: "Joe",
      last_name:  "Tester",
      email:      "joetester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )

    user_2 = User.create(
      first_name: "Bill",
      last_name:  "Tester",
      email:      "billtester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )

    project_1 = user_1.projects.create(
      name: "Test Project",
    )

    project_2 = user_2.projects.build(
      name:  "Test Project",
    )

    expect(project_2).to be_valid
  end
end
