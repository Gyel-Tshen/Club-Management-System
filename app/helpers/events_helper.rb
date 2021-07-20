module EventsHelper
    def booking_button(event)
        if event.user == current_user
            link_to "You have created this event", event_path(event)
        elsif event.bookings.where(user: current_user).any?
            button_to "Unregister", bookings_path, method: :delete, data: { confirm: 'Are you sure?' }, class:"btn btn-sm btn-danger"
        elsif event.event_category == "PAST"
            link_to "This event is already finished", event_path(event)
        else
            link_to "Register", new_event_booking_path(event), class: 'btn btn-success'
        end
    end

    def event_category(event_category)
        if event_category == "UPCOMING"
            content_tag :span, "#{event_category}", class: "tag is-primary"
        elsif event_category == "PAST"
            content_tag :span, "#{event_category}", class: "tag is-link"
        elsif event_category == "CURRENT"
            content_tag :span, "#{event_category}", class: "tag is-warning"
        else
            ""
        end
    end
end
