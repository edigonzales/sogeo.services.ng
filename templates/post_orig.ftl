<#include "header.ftl">

	<#include "menu.ftl">

	<div class="page-header">
		<h1><#escape x as x?xml>${content.title}</#escape></h1>
	</div>

	<p class="date"><em>${content.date?string("dd MMMM yyyy")}</em></p>

	<p>${content.body}</p>

	<p class="author">
		Posted by ${content.author}. |
		<#list content.tags as tag><a href="/tags/${tag}.html">${tag}</a>
		<#if tag_has_next>, </#if></#list>
	</p>

	<hr />

<#include "footer.ftl">