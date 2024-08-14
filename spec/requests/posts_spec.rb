require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = User.create(email: 'akk@gmail.com', password: 'asd123', password_confirmation: 'asd123')
    @post = Post.create(title: 'post', content: 'This is a post.', user: @user)
    sign_in @user
  end

  describe "GET /posts" do
    it "renders the index template" do
      get posts_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /posts/:id" do
    it "renders the show template" do
      get post_path(@post)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /posts/new" do
    it "renders the new template" do
      get new_post_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST /posts" do
    context "with valid attributes" do
      it "creates a new post and redirects to the post page" do
        post_params = { post: { title: "New Post", content: "Content of the new post" } }
        post posts_path, params: post_params
        expect(response).to redirect_to(post_path(Post.last))
        expect(Post.last.title).to eq("New Post")
      end
    end
  
    context "with invalid attributes" do
      it "does not create a new post and re-renders the new template" do
        post_params = { post: { title: "", content: "Content of the new post" } }
        post posts_path, params: post_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end  

  describe "PATCH /posts/:id" do
    context "with valid attributes" do
      it "updates the post and redirects to the post page" do
        patch_params = { post: { title: "Updated Post Title", content: "Updated content", user_id: @user.id } }
        patch post_path(@post), params: patch_params
  
        @post.reload
        expect(response).to redirect_to(post_path(@post))
        expect(@post.title).to eq("Updated Post Title")
        expect(@post.content).to eq("Updated content")
      end
    end
  
    context "with invalid attributes" do
      it "does not update the post and re-renders the edit template" do
        patch_params = { post: { title: "", content: "Updated content", user_id: @user.id } }
        patch post_path(@post), params: patch_params
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE /posts/:id" do
    it "deletes the post and redirects to the posts index" do
      expect {
        delete post_path(@post)
      }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end
