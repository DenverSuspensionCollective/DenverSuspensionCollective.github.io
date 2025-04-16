---
layout: standalone
title: Events
---

<p class="lead">
We host monthly hook suspension events in Colorado.
Please <a href="{% link contact.md %}">contact us</a> if you're interested in attending.
</p>

<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
{% assign sorted_meets = site.data.events.monthly_meets | sort: 'start_date' %}

{% for event in sorted_meets %}
<div class="col">
    <div class="card">
        <div class="card-body">
            <h5 class="card-title mb-2">
                {% if event.name %}
                    {% if event.page %}
                        <a href="{% link {{ event.page }} %}">{{ event.name }}</a>
                    {% else %}
                        {{ event.name }}
                    {% endif %}
                {% else %}
                    Suspension {{ event.start_date | date: "%A" }}
                {% endif %}
            </h5>
            <p class="card-text mb-2">
                <i class="bi bi-calendar-event"></i>
                {% if event.end_date %}
                    {{ event.start_date | date: "%B %-d" }} &mdash; {{ event.end_date | date: "%B %-d, %Y" }}
                {% else %}
                    {{ event.start_date | date: "%B %-d, %Y" }}
                {% endif %}
            </p>
            <p class="card-text">
                <i class="bi bi-geo-alt-fill"></i>
                {% if event.location %}
                    {{ event.location }}
                {% else %}
                    Denver, CO
                {% endif %}
            </p>
        </div>
    </div>
</div>
{% endfor %}
</div>

<p class="text-secondary mt-4">
For a list of global suspension events, please check out
<a href="https://calendar.google.com/calendar/embed?src=suspension.events%40gmail.com" target="_blank">this calendar</a>.
</p>

<br/>

<h3 class="h3">Past Events</h3>

<p>
    In addition to monthly meets, we occasionally host larger events.
</p>

{% assign past_events = site.data.events.past_events | sort: 'start_date' %}
<ul>
{% for event in past_events %}
<li>
    <a href="{% link {{ event.page }} %}">{{ event.name }}</a>
</li>
{% endfor %}
</ul>
