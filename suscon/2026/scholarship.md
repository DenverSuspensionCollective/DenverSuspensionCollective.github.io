---
layout: standalone
title: 2026 Suscon Scholarship
event_id: suscon2026
image:
  file: suscon2026.jpg
  sub_dir: events
---

{% assign event_id = page.event_id %}
{% assign event = site.data[event_id] %}
{% assign form_link = event.details.scholarship.form %}
{% capture email_link %}mailto:{{ event.details.scholarship.email | encode_email }}{% endcapture %}

<p class="lead">
    The Denver Suspension Collective is committed to keeping education accessible and available and we understand
    that events can be cost prohibitive for many practitioners. The DSC has four full Suscon 2026 scholarships available.
    Scholarships include a full event pass for the <a href="{% link suscon/2026/index.md %}">2026 Denver Suscon</a>,
    an event t-shirt, and one suspension. Scholarships do not include lodging or accommodations.
</p>

<div class="alert alert-info my-4 fw-medium" role="alert">
    <b><i class="bi bi-info-circle-fill"></i></b>
    Applications must be completed and submitted by January 31.
    Recipients will be contacted via email by February 7.
    Submitting an application does not guarantee a scholarship.
    Please wait until you’ve been notified to book accommodations.
    <br><br>
    For any questions, please email: <a href="{{ email_link }}" class="alert-link">DenverSusconScholarship [at] gmail [dot] com</a>
</div>

{% include heading_block.html title="Eligibility for Application" icon="bi-list-stars" %}

**Community Involvement**: Applicants must be active members of the suspension community or aspiring practitioners and plan to attend the Denver Suscon with the intention of gaining practitioner experience.

**Financial Need:** This scholarship is intended for practitioners who cannot attend the event without financial assistance. You will not be asked to prove or explain your decision for applying, we trust you to understand your own needs when deciding if a scholarship is right for you.

**Commitment to Skill Development:** Applicants must be interested in improving skills as a practitioner, and display an openness to learning and feedback. The Denver Suscon is an education focused event, attendees must be committed to participating in classes and hands-on learning opportunities.

**Code of Conduct and Professionalism:** Applicants must be willing to abide by the DSC [Code of Conduct]({% link resources/general/code-of-conduct.md %}). The DSC reserves the right to revoke the scholarship or remove the attendee for any behavior that violates the CoC.

**Ability to Volunteer as Needed:** Applicants may be asked to volunteer during the Denver Suscon as needed. Volunteer duties may include: load-in, load-out, and registration. Learning opportunities and suspensions will take priority.

**Cost of Travel and Lodging:** The DSC Scholarship does not provide accommodations such as lodging or travel cost. Applicants must be able to provide their own necessary accommodations.

{% include heading_block.html title="Application Requirements" icon="bi-award" %}

All requested information on the scholarship application must be completed honestly and thoroughly. Incomplete or inaccurate applications will not be considered. Applicants will not be required to prove financial need but will be required to complete a short application and a 5-8 sentence essay describing how they would benefit from attending the Denver Suscon.

{% if form_link == null %}
    {% assign is_closed = true %}
    {% assign btn_text = "Applications Closed" %}
    {% assign disabled = "disabled" %}
{% else %}
    {% assign is_closed = false %}
    {% assign btn_text = "Apply Now" %}
    {% assign disabled = "" %}
{% endif %}

 <div class="d-grid gap-2 col-8 mx-auto my-2">
    <a {% if is_closed == false %} href="{{ form_link }}" {% endif %}
        class="btn btn-primary btn-lg {{ disabled }}"
        role="button"
        aria-disabled="{{ is_closed }}"
        target="_blank"
    >
        {{ btn_text }}
    </a>
</div>
