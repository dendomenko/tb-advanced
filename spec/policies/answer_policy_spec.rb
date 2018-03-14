require 'rails_helper'

RSpec.describe AnswerPolicy do
  subject { AnswerPolicy.new(user, answer) }

  let(:answer) { create(:answer) }

  context "for a visitor" do
    let(:user) { nil }

    it { should     permit(:show)    }

    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for an user" do
    let(:user) { create(:user) }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
    it { should permit(:not_author) }
  end

  context "for an author" do
    let(:user) { create(:user) }
    let(:answer) { create(:answer, user: user) }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
    it { should_not permit(:not_author) }

  end
end