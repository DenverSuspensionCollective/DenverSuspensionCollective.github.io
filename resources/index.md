---
layout: standalone
title: Resources
---

{% for item in site.data.navigation %}
{% if item.title == "resources" %}
<ul>
    {% for sub_item in item.submenu %}
    <li>
        <a href="{% link {{ sub_item.page }} %}">{{ sub_item.title }}</a>
    </li>
    {% endfor %}
</ul>
{% endif %}
{% endfor %}
