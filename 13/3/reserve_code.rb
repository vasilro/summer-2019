#code for place.erb

<div class="container">
 <% if @place.testimonials %>
  <p class="title is-2">Testimonials:</p>
    <% testimonials = @place.testimonials.includes(:user) %>
    <% testimonials.each do |testimonial| %>
      <p><%= "#{testimonial.user.name}: #{testimonial.text} #{testimonial.rating}"%></p>
    <% end %>
<% end %>
</div>
