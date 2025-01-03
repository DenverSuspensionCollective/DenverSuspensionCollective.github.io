---
layout: standalone
title: Events
---

<p class="lead">
We host monthly events in Colorado.
Please <a href="{% link contact.md %}">contact us</a> if you're interested in attending.
</p>

<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
    {% assign today_date = 'now' | date: '%Y-%m-%d' %}
    {% for event in site.data.events %}
      {% assign event_date = event.start_date | date: '%Y-%m-%d' %}
      {% if event_date >= today_date %}
        <div class="col">
          <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">{{ event.name }}</h5>
                <p class="card-text">
                    <i class="bi bi-geo-alt-fill"></i> {{ event.location }}
                </p>
                <p class="card-text">
                    <i class="bi bi-calendar-event"></i>
                    {% if event.end_date %}
                        {{ event.start_date | date: "%B %-d" }} &mdash; {{ event.end_date | date: "%B %-d, %Y" }}
                    {% else %}
                        {{ event.start_date | date: "%B %-d, %Y" }}
                    {% endif %}
                </p>
            </div>
        </div>
    </div>
    {% endif %}
{% endfor %}
</div>
