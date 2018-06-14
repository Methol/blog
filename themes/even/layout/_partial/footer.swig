{# Social Links #}
{% include "./_footer/social.swig" %}

<div class="copyright">

  <span class="copyright-year">
    {% set current = date(Date.now(), "YYYY") %}
    &copy; 
    {% if theme.since and theme.since != current %} 
      {{ theme.since }} - 
    {% endif %}
    {{ current }}

    <span class="heart">
      <i class="iconfont icon-heart"></i>
    </span>
    <span class="author">{{ config.author }}</span>
  </span>

  <span class="power-by">
    <a href="http://www.miitbeian.gov.cn/" target="_blank">鄂ICP备15021398号 | 鄂公网安备 42011102000434号</a>
  </span>

</div>
