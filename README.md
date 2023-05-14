# Blog with GraphQL

## Installation

In order to get the application running you need to do as follows:

- Make sure that you are using a ruby version which is definied in .ruby-version

- Execute: `bundle install`

## Usage

To experiment with that code, run `rails c` for an interactive prompt, or launch the application with `rails s`

## TEST

You can run tests by: `rspec`.

You can generate test coverage by setting the SIMPLECOV environment variable to true: `SIMPLECOV=true rspec` which should generate an overview of 100% coverage to the 'coverage' folder.

## Description
Develop a GraphQL API for a simple blog using Ruby on Rails. The API should allow
users to create, read, update and delete blog posts.
### Requirements
- Users should be able to sign up and login.
- Users should be able to create, read, update and delete blog posts.
- Each blog should have a title, body and author.
- The home page of the blog should display a list of all blog posts, sorted by most recent
first.
- The blog should have a search functionality that allows users to search for posts by
title or author.
- The blog should have pagination which displays 10 posts per page.
- Use Ruby on Rails to build the blog.
- Use a database to store the blog posts and user information.
- Write tests to ensure the functionality.
- Allow users to add comments to blog posts.
- Implement user roles (e.g. admin, writer, editor) with different levels of permissions.
- Add tags to your blog and allow users to filter posts by tag.
