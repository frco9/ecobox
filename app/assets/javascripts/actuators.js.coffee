jQuery(document).on 'page:change', ->
	$('input:checkbox').bootstrapSwitch()
	$('#dimension-switch').bootstrapSwitch('onColor', 'success');

