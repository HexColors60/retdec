/**
* @file tests/bin2llvmir/optimizations/writer_dsm/tests/writer_dsm_tests.cpp
* @brief Tests for the @c DsmWriter pass.
* @copyright (c) 2017 Avast Software, licensed under the MIT license
*/

#include <regex>
#include <sstream>

#include "retdec/bin2llvmir/optimizations/writer_dsm/writer_dsm.h"
#include "bin2llvmir/utils/llvmir_tests.h"

using namespace ::testing;
using namespace llvm;

namespace retdec {
namespace bin2llvmir {
namespace tests {

/**
 * @brief Tests for the @c DsmGenerator pass.
 */
class DsmWriterTests: public LlvmIrTests
{
	protected:
		DsmWriter pass;
};

TEST_F(DsmWriterTests, testHeaderGeneration)
{
	parseInput(R"(
		@whatever = global i64 0
	)");

	auto c = config::Config::fromJsonString(R"({
		"architecture" : {
			"bitSize" : 32,
			"endian" : "little",
			"name" : "arm"
		}
	})");
	auto config = Config::fromConfig(module.get(), c);
	auto abi = AbiProvider::addAbi(module.get(), &config);
	auto format = createFormat();
	auto image = FileImage(module.get(), std::move(format), &config);

	std::stringstream ret;
	bool b = pass.runOnModuleCustom(*module, &config, &image, abi, ret);

	std::string ref =
R"(^;;
;; This file was generated by the Retargetable Decompiler
;; Website: https://retdec.com
;; Copyright \(c\) 20.. Retargetable Decompiler <info@retdec.com>
;;
;; Decompilation date: ....-..-.. ..:..:..
;; Architecture: arm
;;

;;
;; Code Segment
;;


;;
;; Data Segment
;;
)";

	bool matched = std::regex_search(ret.str(), std::regex(ref));

	EXPECT_FALSE(b);
	EXPECT_TRUE(matched)
			<< "expected:\n" << ref
			<< "\nactual:\n" << ret.str() << "\n";
}

} // namespace tests
} // namespace bin2llvmir
} // namespace retdec