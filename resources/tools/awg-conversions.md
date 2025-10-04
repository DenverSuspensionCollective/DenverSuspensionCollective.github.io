---
layout: standalone
title: American Wire Gauge Conversions
---

*American Wire Gauge (AWG) Conversion Chart for Imperial and Metric units.*

<div class="table-responsive">
    <table class="table table-striped table-bordered align-middle">
        <thead>
            <tr>
                <th scope="col">Wire Gauge</th>
                <th scope="col">Millimeters</th>
                <th scope="col">Inches (decimal)</th>
                <th scope="col">Inches (fractional)</th>
            </tr>
        </thead>
        <tbody>
            {% for item in site.data.resources.awg_conversions %}
            <tr class="{% if item.highlight %} table-info {% endif %}">
                <td>
                    {% if item.awg %} <span class="font-monospace">{{ item.awg }}</span> g
                    {% else %} &mdash; {% endif %}
                </td>
                <td>
                    {% if item.mm %} <span class="font-monospace">{{ item.mm }}</span> mm
                    {% else %} &mdash; {% endif %}
                </td>
                <td>
                    {% if item.inch_decimal %} <span class="font-monospace">{{ item.inch_decimal }}</span> in
                    {% else %} &mdash; {% endif %}
                </td>
                <td>
                    {% if item.inch_fractional %} <span class="font-monospace">{{ item.inch_fractional }}</span> in
                    {% else %} &mdash; {% endif %}
                </td>
            </tr>
            {% endfor %}
        </tbody>
    </table>
</div>
