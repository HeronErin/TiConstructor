/** @file errors.c @brief Some simple ways to throw an error */
#pragma once



/** @brief Show the error screen with custom text
 * 	@param[error_text] The error text to be displayed (LIMITED TO 11 in length)
 * 
 * 	This error uses a bcall so it should return
 */ 
void CustomError(char* error_text) __naked __z88dk_callee{
	#asm
		pop de
		pop hl
		push de

		ld de, appErr1
		ld bc, 11
		ldir

		abcall(_ErrCustom1)
		ret
	__endasm;
}




/** @{ \name Normal system errors, uses bjumps so this effectivly exists the program */



/**
 * @brief Raises a syntax error and jumps to the error handling routine.
 */
#define SyntaxError() bjump( _ErrSyntax )

/**
 * @brief Raises an overflow error and jumps to the error handling routine.
 */
#define OverflowError() bjump( _ErrOverflow )

/**
 * @brief Raises a divide-by-zero error and jumps to the error handling routine.
 */
#define DivideByZeroError() bjump( _ErrDivBy0 )

/**
 * @brief Raises a singularity error and jumps to the error handling routine.
 */
#define SingularityError() bjump( _ErrSingularMat )

/**
 * @brief Raises a domain error and jumps to the error handling routine.
 */
#define DomainError() bjump( _ErrDomain )

/**
 * @brief Raises an increment error and jumps to the error handling routine.
 */
#define IncrementError() bjump( _ErrIncrement )

/**
 * @brief Raises a non-real error and jumps to the error handling routine.
 */
#define NonRealError() bjump( _ErrNon_Real )

/**
 * @brief Raises a data type error and jumps to the error handling routine.
 */
#define DataTypeError() bjump( _ErrDataType )

/**
 * @brief Raises an argument error and jumps to the error handling routine.
 */
#define ArgumentError() bjump( _ErrArgument )

/**
 * @brief Raises a dimension mismatch error and jumps to the error handling routine.
 */
#define DimensionMismatchError() bjump( _ErrDimMismatch )

/**
 * @brief Raises a dimension error and jumps to the error handling routine.
 */
#define DimensionError() bjump( _ErrDimension )

/**
 * @brief Raises an undefined error and jumps to the error handling routine.
 */
#define UndefinedError() bjump( _ErrUndefined )

/**
 * @brief Raises a memory error and jumps to the error handling routine.
 */
#define MemoryError() bjump( _ErrMemory )

/**
 * @brief Raises an invalid error and jumps to the error handling routine.
 */
#define InvalidError() bjump( _ErrInvalid )

/**
 * @brief Raises a break error and jumps to the error handling routine.
 */
#define BreakError() bjump( _ErrBreak )

/**
 * @brief Raises a stat error and jumps to the error handling routine.
 */
#define StatError() bjump( _ErrStat )

/**
 * @brief Raises a no sign change error and jumps to the error handling routine.
 */
#define NoSignChangeError() bjump( _ErrSignChange )

/**
 * @brief Raises an iterations error and jumps to the error handling routine.
 */
#define IterationsError() bjump( _ErrIterations )

/**
 * @brief Raises a bad guess error and jumps to the error handling routine.
 */
#define BadGuessError() bjump( _ErrBadGuess )

/**
 * @brief Raises a tolerance not met error and jumps to the error handling routine.
 */
#define TolNotMetError() bjump( _ErrTolTooSmall )

/**
 * @brief Raises a stat plot error and jumps to the error handling routine.
 */
#define StatPlotError() bjump( _ErrStatPlot )

/**
 * @brief Raises a link error and jumps to the error handling routine.
 */
#define LinkError() bjump( _ErrLinkXmit )



/** @} */
