class ProcessMemoryItem < ApplicationRecord
  belongs_to :process_property

  validates :memory, numericality: true
  validates :memory, presence: true

  def self.chart_data
    select('process_properties.name', 'process_memory_items.memory', 'process_memory_items.created_at')
      .joins(:process_property)
      .order(created_at: :asc)
      .group_by(&:name)
      .each_with_object([]) do |(process_name, data), ary|
        ary << {
          name: process_name,
          data: data.map {|pmi| [pmi.created_at, pmi.memory] }
        }
      end
  end
end
