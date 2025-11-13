using System;
using System.Collections.Generic;
using System.Linq;
using Godot;

namespace ddrcast;

public partial class ComplexityCalculator : Node
{
	private const double CompressabilityFactor = 0.5f;
	private const double NoRepeatsFactor = 0.8f;
	private const double EntropyFactor = 0.5f;

	public double GetComplexity(List<Direction> spellInput)
	{
		return BaseLengthMultiplier(spellInput) 
		       * Math.Pow(
			       (((CompressabilityMultiplier(spellInput) - 1) * CompressabilityFactor) + 1)
			       * (((NoRepeatsBonus(spellInput) - 1) * NoRepeatsFactor) + 1)
			       * (1 + (PatternEntropy(spellInput) * EntropyFactor / 2))
			       , 1.3);
	}

	private static double PatternEntropy(IList<Direction> spellInput)
	{
		double entropy = 0.0;
		var groups = spellInput.GroupBy(i => i);
		foreach (var group in groups)
		{
			if (!group.Any()) continue;
			double charProbability = (double) group.Count() / spellInput.Count;
			entropy -= charProbability * Math.Log2(charProbability);
		}

		return entropy;
	}

	private static double BaseLengthMultiplier(IList<Direction> spellInput)
	{
		return (spellInput.Count - 1) * 0.1 + 1;
	}

	private static double CompressabilityMultiplier(List<Direction> spellInput)
	{
		double frac = spellInput.Count / (1.0 + spellInput.Count - LempelZiv(spellInput).Item1);
		return Math.Log10(9 + Math.Max(1, frac));
	}

	private class DirectionListComparer : IEqualityComparer<IList<Direction>>
	{
		public bool Equals(IList<Direction> x, IList<Direction> y)
		{
			if (x is null && y is null) return true;
			if (x is null || y is null) return false;
			return x.SequenceEqual(y);
		}

		public int GetHashCode(IList<Direction> obj)
		{
			const int seed = 487;
			const int modifier = 31;
			return obj.Aggregate(seed, (current, item) =>
				(current*modifier) + item.GetHashCode());
		}
	}
	
	private static (int, int) LempelZiv(IList<Direction> spellInput)
	{
		var encodingDict = new Dictionary<IList<Direction>, string>(new DirectionListComparer());
		foreach (Direction dir in Enum.GetValues<Direction>())
			if (spellInput.Contains(dir)) 
				encodingDict.Add(spellInput, encodingDict.Count.ToString());
		
		var workingString = new List<Direction>();
		int outputCodes = 0;

		foreach (Direction input in spellInput)
		{
			var nextEncodingSymbol = workingString.Concat([input]).ToList();
			if (encodingDict.ContainsKey(nextEncodingSymbol))
			{
				workingString.Add(input);
			}
			else
			{
				outputCodes++;
				encodingDict.Add(nextEncodingSymbol, encodingDict.Count.ToString());
				workingString = [input];
			}
		}

		outputCodes++;
		return (outputCodes, encodingDict.Count);
	}

	private const double LowerBound = 0.7f;
	private const double MaxBonusScaling = 1.3f;
	private const double LengthForDouble = 18.0f;
	private const double ProportionForHalfBonus = 0.2f;
	private const double Steepness = 1.25f;
	private const double Skew = 1.5f;

	private static double NoRepeatsBonus(IList<Direction> spellInput)
	{
		double upperBound = 1.0 + Math.Pow((spellInput.Count / LengthForDouble), MaxBonusScaling);
		// intermediate variable so it doesn't get hairy
		double midShiftInsideLn = 
			(Math.Pow((upperBound - LowerBound), Skew) /
			 Math.Pow((((upperBound + LowerBound) / 2.0) - LowerBound), Skew)) 
			- 1;
		double midShift = spellInput.Count * ProportionForHalfBonus - (1.0 / Steepness) * Math.Log(midShiftInsideLn);

		double exponent = Steepness * (CountRepeatedInputs(spellInput) - midShift);
		double bottomOfFrac = Math.Pow(1 + Math.Pow(Math.E, exponent), 1.0 / Skew);
		return Math.Max(1, LowerBound + ((upperBound - LowerBound) / bottomOfFrac));
	}

	private static int CountRepeatedInputs(IList<Direction> spellInput)
	{
		if (spellInput.Count is 0 or 1) return 0;
		int count = 0;
		for (int i = 0; i < spellInput.Count - 1; i++)
		{
			if (spellInput[i].Equals(spellInput[i + 1])) count++;
		}
		return count;
	}
}