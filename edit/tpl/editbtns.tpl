<div>
	<?php if ($btns == "full"): ?>
		<input type="button" value="větší nadpis" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<h5>','</h5>');" />
		<input type="button" value="menší nadpis" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<h6>','</h6>');" />
		<input type="button" value="odstavec" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<p>','</p>');" />
	<?php endif; ?>
	<input type="button" value="tučné" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<strong>','</strong>');" />
	<input type="button" value="kurzíva" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<em>','</em>');" />
	<?php if (!$nolink): ?>
		<input type="button" value="odkaz" class="smallbutton" onclick="wrapSelectionWithLink(<?php echo $txtarea; ?>);" />
	<?php endif; ?>
</div>
<div>
	<?php if ($btns == "full"): ?>
		<input type="button" value="horní index" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<sup>','</sup>');" />
		<input type="button" value="dolní index" class="smallbutton" onclick="wrapSelection(<?php echo $txtarea; ?>,'<sub>','</sub>');" />
	<?php endif; ?>
</div>