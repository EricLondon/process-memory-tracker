class ProcessProperty < ApplicationRecord
  has_many :process_memory_items, dependent: :destroy
  validates :name, presence: true

  def grep_name
    @grep_name ||= "[#{name[0]}]#{name[1..-1]}"
  end
end
