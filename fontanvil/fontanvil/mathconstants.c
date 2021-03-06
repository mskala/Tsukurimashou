/* $Id: mathconstants.c 4302 2015-10-24 15:00:46Z mskala $ */
/* Copyright (C) 2007-2012  George Williams
 * Copyright (C) 2015  Matthew Skala
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "fontanvilvw.h"
#ifdef __need_size_t
/* This is a bug on the mac, someone defines this and leaves it defined */
/*  that means when I load stddef.h it only defines size_t and doesn't */
/*  do offset_of, which is what I need */
#   undef __need_size_t
#endif
#include <stddef.h>

#define MCD(ui_name,name,msg,np) { ui_name, #name, offsetof(struct MATH,name), -1,msg,np }
#define MCDD(ui_name,name,devtab_name,msg,np) { ui_name, #name, offsetof(struct MATH,name), offsetof(struct MATH,devtab_name),msg,np }

struct math_constants_descriptor math_constants_descriptor[]={
   MCD("ScriptPercentScaleDown:", ScriptPercentScaleDown,
       "Percentage scale down for script level 1", 0),
   MCD("ScriptScriptPercentScaleDown:", ScriptScriptPercentScaleDown,
       "Percentage scale down for script level 2", 0),
   MCD("DelimitedSubFormulaMinHeight:", DelimitedSubFormulaMinHeight,
       "Minimum height at which to treat a delimited\nexpression as a subformula",
       0),
   MCD("DisplayOperatorMinHeight:", DisplayOperatorMinHeight,
       "Minimum height of n-ary operators (integration, summation, etc.)",
       0),
   MCDD("MathLeading:", MathLeading, MathLeading_adjust,
	"White space to be left between math formulae\nto ensure proper line spacing.",
	0),
   MCDD("AxisHeight:", AxisHeight, AxisHeight_adjust,
	"Axis height of the font", 0),
   MCDD("AccentBaseHeight:", AccentBaseHeight, AccentBaseHeight_adjust,
	"Maximum (ink) height of accent base that\ndoes not require raising the accents.",
	0),
   MCDD("FlattenedAccentBaseHeight:", FlattenedAccentBaseHeight,
	FlattenedAccentBaseHeight_adjust,
	"Maximum (ink) height of accent base that\ndoes not require flattening the accents.",
	0),
   MCDD("SubscriptShiftDown:", SubscriptShiftDown,
	SubscriptShiftDown_adjust,
	"The standard shift down applied to subscript elements.\nPositive for moving downward.",
	1),
   MCDD("SubscriptTopMax:", SubscriptTopMax, SubscriptTopMax_adjust,
	"Maximum height of the (ink) top of subscripts\nthat does not require moving\nsubscripts further down.",
	0),
   MCDD("SubscriptBaselineDropMin:", SubscriptBaselineDropMin,
	SubscriptBaselineDropMin_adjust,
	"Maximum allowed drop of the baseline of\nsubscripts relative to the bottom of the base.\nUsed for bases that are treated as a box\nor extended shape. Positive for subscript\nbaseline dropped below base bottom.",
	0),
   MCDD("SuperscriptShiftUp:", SuperscriptShiftUp,
	SuperscriptShiftUp_adjust,
	"Standard shift up applied to superscript elements.", 0),
   MCDD("SuperscriptShiftUpCramped:", SuperscriptShiftUpCramped,
	SuperscriptShiftUpCramped_adjust,
	"Standard shift of superscript relative\nto base in cramped mode.",
	0),
   MCDD("SuperscriptBottomMin:", SuperscriptBottomMin,
	SuperscriptBottomMin_adjust,
	"Minimum allowed height of the bottom\nof superscripts that does not require moving\nthem further up.",
	0),
   MCDD("SuperscriptBaselineDropMax:", SuperscriptBaselineDropMax,
	SuperscriptBaselineDropMax_adjust,
	"Maximum allowed drop of the baseline of\nsuperscripts relative to the top of the base.\nUsed for bases that are treated as a box\nor extended shape. Positive for superscript\nbaseline below base top.",
	0),
   MCDD("SubSuperscriptGapMin:", SubSuperscriptGapMin,
	SubSuperscriptGapMin_adjust,
	"Minimum gap between the superscript and subscript ink.", 0),
   MCDD("SuperscriptBottomMaxWithSubscript:",
	SuperscriptBottomMaxWithSubscript,
	SuperscriptBottomMaxWithSubscript_adjust,
	"The maximum level to which the (ink) bottom\nof superscript can be pushed to increase the\ngap between superscript and subscript, before\nsubscript starts being moved down.",
	0),
   MCDD("SpaceAfterScript:", SpaceAfterScript, SpaceAfterScript_adjust,
	"Extra white space to be added after each\nsub/superscript.", 0),
   MCDD("UpperLimitGapMin:", UpperLimitGapMin, UpperLimitGapMin_adjust,
	"Minimum gap between the bottom of the\nupper limit, and the top of the base operator.",
	1),
   MCDD("UpperLimitBaselineRiseMin:", UpperLimitBaselineRiseMin,
	UpperLimitBaselineRiseMin_adjust,
	"Minimum distance between the baseline of an upper\nlimit and the bottom of the base operator.",
	0),
   MCDD("LowerLimitGapMin:", LowerLimitGapMin, LowerLimitGapMin_adjust,
	"Minimum gap between (ink) top of the lower limit,\nand (ink) bottom of the base operator.",
	0),
   MCDD("LowerLimitBaselineDropMin:", LowerLimitBaselineDropMin,
	LowerLimitBaselineDropMin_adjust,
	"Minimum distance between the baseline of the\nlower limit and bottom of the base operator.",
	0),
   MCDD("StackTopShiftUp:", StackTopShiftUp, StackTopShiftUp_adjust,
	"Standard shift up applied to the top element of a stack.", 1),
   MCDD("StackTopDisplayStyleShiftUp:", StackTopDisplayStyleShiftUp,
	StackTopDisplayStyleShiftUp_adjust,
	"Standard shift up applied to the top element of\na stack in display style.",
	0),
   MCDD("StackBottomShiftDown:", StackBottomShiftDown,
	StackBottomShiftDown_adjust,
	"Standard shift down applied to the bottom element of a stack.\nPositive values indicate downward motion.",
	0),
   MCDD("StackBottomDisplayStyleShiftDown:",
	StackBottomDisplayStyleShiftDown,
	StackBottomDisplayStyleShiftDown_adjust,
	"Standard shift down applied to the bottom\nelement of a stack in display style.\nPositive values indicate downward motion.",
	0),
   MCDD("StackGapMin:", StackGapMin, StackGapMin_adjust,
	"Minimum gap between bottom of the top\nelement of a stack, and the top of the bottom element.",
	0),
   MCDD("StackDisplayStyleGapMin:", StackDisplayStyleGapMin,
	StackDisplayStyleGapMin_adjust,
	"Minimum gap between bottom of the top\nelement of a stack and the top of the bottom\nelement in display style.",
	0),
   MCDD("StretchStackTopShiftUp:", StretchStackTopShiftUp,
	StretchStackTopShiftUp_adjust,
	"Standard shift up applied to the top element of the stretch stack.",
	0),
   MCDD("StretchStackBottomShiftDown:", StretchStackBottomShiftDown,
	StretchStackBottomShiftDown_adjust,
	"Standard shift down applied to the bottom\nelement of the stretch stack.\nPositive values indicate downward motion.",
	0),
   MCDD("StretchStackGapAboveMin:", StretchStackGapAboveMin,
	StretchStackGapAboveMin_adjust,
	"Minimum gap between the ink of the stretched\nelement and the ink bottom of the element\nabove..",
	0),
   MCDD("StretchStackGapBelowMin:", StretchStackGapBelowMin,
	StretchStackGapBelowMin_adjust,
	"Minimum gap between the ink of the stretched\nelement and the ink top of the element below.",
	0),
   MCDD("FractionNumeratorShiftUp:", FractionNumeratorShiftUp,
	FractionNumeratorShiftUp_adjust,
	"Standard shift up applied to the numerator.", 1),
   MCDD("FractionNumeratorDisplayStyleShiftUp:",
	FractionNumeratorDisplayStyleShiftUp,
	FractionNumeratorDisplayStyleShiftUp_adjust,
	"Standard shift up applied to the\nnumerator in display style.",
	0),
   MCDD("FractionDenominatorShiftDown:", FractionDenominatorShiftDown,
	FractionDenominatorShiftDown_adjust,
	"Standard shift down applied to the denominator.\nPositive values indicate downward motion.",
	0),
   MCDD("FractionDenominatorDisplayStyleShiftDown:",
	FractionDenominatorDisplayStyleShiftDown,
	FractionDenominatorDisplayStyleShiftDown_adjust,
	"Standard shift down applied to the\ndenominator in display style.\nPositive values indicate downward motion.",
	0),
   MCDD("FractionNumeratorGapMin:", FractionNumeratorGapMin,
	FractionNumeratorGapMin_adjust,
	"Minimum tolerated gap between the ink\nbottom of the numerator and the ink of the fraction bar.",
	0),
   MCDD("FractionNumeratorDisplayStyleGapMin:",
	FractionNumeratorDisplayStyleGapMin,
	FractionNumeratorDisplayStyleGapMin_adjust,
	"Minimum tolerated gap between the ink\nbottom of the numerator and the ink of the fraction\nbar in display style.",
	0),
   MCDD("FractionRuleThickness:", FractionRuleThickness,
	FractionRuleThickness_adjust, "Thickness of the fraction bar.",
	0),
   MCDD("FractionDenominatorGapMin:", FractionDenominatorGapMin,
	FractionDenominatorGapMin_adjust,
	"Minimum tolerated gap between the ink top of the denominator\nand the ink of the fraction bar..",
	0),
   MCDD("FractionDenominatorDisplayStyleGapMin:",
	FractionDenominatorDisplayStyleGapMin,
	FractionDenominatorDisplayStyleGapMin_adjust,
	"Minimum tolerated gap between the ink top of the denominator\nand the ink of the fraction bar in display style.",
	0),
   MCDD("SkewedFractionHorizontalGap:", SkewedFractionHorizontalGap,
	SkewedFractionHorizontalGap_adjust,
	"Horizontal distance between the top\nand bottom elements of a skewed fraction.",
	0),
   MCDD("SkewedFractionVerticalGap:", SkewedFractionVerticalGap,
	SkewedFractionVerticalGap_adjust,
	"Vertical distance between the ink of the top and\nbottom elements of a skewed fraction.",
	0),
   MCDD("OverbarVerticalGap:", OverbarVerticalGap,
	OverbarVerticalGap_adjust,
	"Distance between the overbar and\nthe ink top of the base.", 1),
   MCDD("OverbarRuleThickness:", OverbarRuleThickness,
	OverbarRuleThickness_adjust, "Thickness of the overbar.", 0),
   MCDD("OverbarExtraAscender:", OverbarExtraAscender,
	OverbarExtraAscender_adjust,
	"Extra white space reserved above the overbar.", 0),
   MCDD("UnderbarVerticalGap:", UnderbarVerticalGap,
	UnderbarVerticalGap_adjust,
	"Distance between underbar and\nthe (ink) bottom of the base.",
	0),
   MCDD("UnderbarRuleThickness:", UnderbarRuleThickness,
	UnderbarRuleThickness_adjust, "Thickness of the underbar.", 0),
   MCDD("UnderbarExtraDescender:", UnderbarExtraDescender,
	UnderbarExtraDescender_adjust,
	"Extra white space reserved below the underbar.", 0),
   MCDD("RadicalVerticalGap:", RadicalVerticalGap,
	RadicalVerticalGap_adjust,
	"Space between the ink to of the\nexpression and the bar over it.",
	1),
   MCDD("RadicalDisplayStyleVerticalGap:", RadicalDisplayStyleVerticalGap,
	RadicalDisplayStyleVerticalGap_adjust,
	"Space between the ink top of the\nexpression and the bar over it in display\nstyle.",
	0),
   MCDD("RadicalRuleThickness:", RadicalRuleThickness,
	RadicalRuleThickness_adjust,
	"Thickness of the radical rule in\ndesigned or constructed radical\nsigns.",
	0),
   MCDD("RadicalExtraAscender:", RadicalExtraAscender,
	RadicalExtraAscender_adjust,
	"Extra white space reserved above the radical.", 0),
   MCDD("RadicalKernBeforeDegree:", RadicalKernBeforeDegree,
	RadicalKernBeforeDegree_adjust,
	"Extra horizontal kern before the degree of a\nradical if such be present.",
	0),
   MCDD("RadicalKernAfterDegree:", RadicalKernAfterDegree,
	RadicalKernAfterDegree_adjust,
	"Negative horizontal kern after the degree of a\nradical if such be present.",
	0),
   MCD("RadicalDegreeBottomRaisePercent:",
       RadicalDegreeBottomRaisePercent,
       "Height of the bottom of the radical degree, if\nsuch be present, in proportion to the ascender\nof the radical sign.",
       0),
   MCD("MinConnectorOverlap:", MinConnectorOverlap,
       "Minimum overlap of connecting glyphs during\nglyph construction.",
       1),
   MATH_CONSTANTS_DESCRIPTOR_EMPTY
};
