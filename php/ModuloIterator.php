<?php
class ModuloIterator extends FilterIterator {
	const FILTER_ISOLATE = true;
	const FILTER_EXCLUDE = false;
	private $_mode;
	private $_modulo;

	function __construct($iterator, $mode = self::FILTER_ISOLATE, $modulo = 2) {
		$this->mode($mode);
		$this->modulo($modulo);
		parent::__construct($iterator);
	}

	function accept() {
		return $this->current() % $this->_modulo XOR $this->_mode;
	}

	function mode($mode = null) {
		if (isset($mode))
			$this->_mode = (boolean)$mode;
		else
			return $this->_mode;
	}

	function modulo($modulo = null) {
		if (isset($modulo)) {
			if ($modulo == 0)
				throw new UnexpectedValueException('Modulo cannot be 0');
			$this->_modulo = (int)$modulo;
		}
		else
			return $this->_modulo;
	}
}

$numbers = new ArrayObject(range(0, 10));
$numbers_it = new ArrayIterator($numbers);
$it = new ModuloIterator($numbers_it, ModuloIterator::FILTER_ISOLATE, 3);
foreach ($it as $number) {
	echo $number . PHP_EOL;
}
?>
