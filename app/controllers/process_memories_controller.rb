class ProcessMemoriesController < ApplicationController
  def index
    @process_memory_data = ProcessMemoryItem.chart_data
  end
end
