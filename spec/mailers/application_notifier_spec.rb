require "spec_helper"

describe ApplicationNotifier do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @vacancy = FactoryGirl.create(:vacancy)
    @moderator = FactoryGirl.create(:moderator)
  end
  describe "new_application" do
    let(:mail) { ApplicationNotifier.new_application(@vacancy, @user) }

    it "renders the headers" do
      mail.subject.should eq("New Job Application by #{@user.fullname} for #{@vacancy.title}")
      mail.to.should eq([Admin.first.email])
      mail.from.should eq(["admin@mini-recruiting.com"])
    end

    it "contains a h1 tag that indicates that an application was created" do
      mail.body.encoded.should match("<h1>A new Job Application was created</h1>")
    end

    it "contains the users name" do
      mail.body.encoded.should match(@user.fullname)
    end

    it "contains the vacancy title" do
      mail.body.encoded.should match(@vacancy.title)
    end
  end

  describe "forwarded_application" do
    let(:mail) { ApplicationNotifier.forwarded_application(@moderator, @vacancy, @user) }

    it "renders the headers" do
      mail.subject.should eq("A job apllication was forwarded to you.")
      mail.to.should eq([@moderator.email])
      mail.from.should eq(["admin@mini-recruiting.com"])
    end

    it "contains the moderators name" do
      mail.body.encoded.should match(@moderator.fullname)
    end

    it "contains the users name" do
      mail.body.encoded.should match(@user.fullname)
    end

    it "contains the vacancy title" do
      mail.body.encoded.should match(@vacancy.title)
    end
  end

  describe "reviewed_application" do
    let(:mail) { ApplicationNotifier.reviewed_application(@moderator, @vacancy, @user) }

    it "renders the headers" do
      mail.subject.should eq("Application by #{@user.fullname} for #{@vacancy.title} was reviewed by #{@moderator.fullname}")
      mail.to.should eq([Admin.first.email])
      mail.from.should eq(["admin@mini-recruiting.com"])
    end

    it "contains a h1 tag that indicates that an application was reviewed" do
      mail.body.encoded.should match("<h1>An Application was reviewed</h1>")
    end

    it "contains the users name" do
      mail.body.encoded.should match(@user.fullname)
    end

    it "contains the vacancy title" do
      mail.body.encoded.should match(@vacancy.title)
    end
  end

  describe "accepted_application" do
    let(:mail) { ApplicationNotifier.accepted_application(@vacancy, @user) }

    it "renders the headers" do
      mail.subject.should eq("Your application for #{@vacancy.title} was accepted.")
      mail.to.should eq([@user.email])
      mail.from.should eq(["admin@mini-recruiting.com"])
    end

    it "contains the users name" do
      mail.body.encoded.should match(@user.fullname)
    end

    it "contains the vacancy title" do
      mail.body.encoded.should match(@vacancy.title)
    end
  end

  describe "rejected_application" do
    let(:mail) { ApplicationNotifier.rejected_application(@vacancy, @user) }

    it "renders the headers" do
      mail.subject.should eq("Your application for #{@vacancy.title} was rejected.")
      mail.to.should eq([@user.email])
      mail.from.should eq(["admin@mini-recruiting.com"])
    end

    it "contains the users name" do
      mail.body.encoded.should match(@user.fullname)
    end

    it "contains the vacancy title" do
      mail.body.encoded.should match(@vacancy.title)
    end
  end

end
