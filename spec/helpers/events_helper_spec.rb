require 'rails_helper'

RSpec.describe EventsHelper, :type => :helper do

	describe 'event countdown' do
		before(:each) do
			user = create(:user)
			@race = create(:event, user: user)
		end

		it 'provides a countdown of the number of days remaining' do
			Timecop.freeze(Time.local(2014, 9, 1, 10, 5, 0)) do
				visit event_path(@race)
				expect(page).to have_content("11 DAYS TO GO")
			end
		end

		it 'displays "Event Day" on day of event' do
			Timecop.freeze(Time.local(2014, 9, 12, 10, 5, 0)) do
				visit event_path(@race)
				expect(page).to have_content("Today's the day!")
			end
		end

		it 'displays "Event Complete" after event date' do
			Timecop.freeze(Time.local(2014, 9, 14, 10, 5, 0)) do
				visit event_path(@race)
				expect(page).to have_content("Event completed 2 days ago!")
			end
		end

	end

  describe '#display_if' do
    it 'should return nothing if test environment is true' do
      expect(display_if(true)).to eq ''
    end

    it 'should return display:none if test environment is false' do
      expect(display_if(false)).to eq 'display:none;'
    end
  end
end
