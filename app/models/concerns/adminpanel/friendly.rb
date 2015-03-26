module Adminpanel
  module Friendly
    extend ActiveSupport::Concern

    included do
      extend FriendlyId

      friendly_id :slug_candidates, use: :slugged

      before_validation :make_slug_nil, if: Proc.new { |object|
        object.name_changed?
      }, prepend: true
    end

    private

      def slug_candidates
        [
          :name,
          :id
        ]
      end

      def make_slug_nil
        self.slug = nil
      end
  end
end
