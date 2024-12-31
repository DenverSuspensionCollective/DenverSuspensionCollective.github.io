---
layout: event-page
title: Retreat
event_date: 2025
location: Studio Friction, Denver
registration_status: open
featured_image: studio_friction.jpg
---

# Denver Suspension Collective Retreat

Join us for the inaugural Denver Suspension Collective Retreat, a registrant-only event focused on education and community. This drug and alcohol-free event will be hosted at Studio Friction in Denver's Lincoln Park neighborhood.

## Event Details

**Dates:** April 12th - 14th, 2025
**Location:** Studio Friction, 740 Lipan St. Denver, CO 80204  
**Registration Required:** [Register Here](https://forms.gle/4x4o13yndPnZAWxF8)

## Schedule

### Saturday
- 7:00 AM - 10:00 AM: Load-in/Setup (volunteers only)
- 10:00 AM - 11:00 AM: Orientation
- 11:30 AM - 1:00 PM: Class/Presentation
- 1:00 PM - 9:00 PM: Suspensions

### Sunday
- 10:00 AM - 11:30 AM: Class/Presentation
- 11:30 AM - 9:00 PM: Suspensions

### Monday
- 10:00 AM - 11:30 AM: Class/Presentation
- 11:30 AM - 7:00 PM: Suspensions
- 7:00 PM - 10:00 PM: Load-out/Cleanup (volunteers only)

## Venue Facilities

We will be hosted by Studio Friction - a rope & aerial centered non-profit community space we have worked with for over a year. The following suspension points will be set up:

- 3 Dynamic Indoor Points
- 1 Aerial Rig Outdoor (weather-permitting)
- 1 Cube

## Presentations

{% for presenter in site.data.retreat_presenters %}
<div class="presenter-card">
    <div class="presenter-image-container">
        <img src="{{ presenter.image }}" alt="{{ presenter.name }}" class="presenter-image">
    </div>
    <div class="presenter-info">
        <h3>{{ presenter.name }}</h3>
        <h4>{{ presenter.presentation_title }}</h4>
        <div class="presentation-description">
            {{ presenter.presentation_description }}
        </div>
        <div class="presenter-bio">
            {{ presenter.bio }}
        </div>
    </div>
</div>
{% endfor %}

## Registration & Pricing

- January 1st - January 31st: $250 USD (Introductory Rate)
- February 1st - March 31st: $300 USD
- April 1st: Registration Closes

## Important Information

### Accommodation
- Not included in registration
- Hotels available approximately 1 mile from venue
- Multiple Airbnb options nearby
- Facebook group available for coordinating shared accommodations

### Food & Refreshments
- Light refreshments provided (vegetarian/vegan options)
- Restaurants within walking distance
- Food delivery services available

### Equipment & Safety

#### Hooks
- Hooks and shackles provided
- All used hooks are processed and sterilized per Denver regulations
- New hooks available for purchase (advance sterilization required)
- Personal hooks must be in unopened sterile packaging

#### COVID Policy
- Masks encouraged during travel
- Rapid tests available if needed
- Hand sanitizer provided throughout venue
- Those with symptoms may be required to mask

{% if site.registration_open %}
<div class="cta-button">
  <a href="https://forms.gle/4x4o13yndPnZAWxF8" class="register-button">Register Now</a>
</div>
{% endif %}

---

*Note: This event is not open to the public. Full information and protocols will be provided upon registration. All participants must complete a consent form.*
