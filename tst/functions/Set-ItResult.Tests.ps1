﻿Set-StrictMode -Version Latest

Describe "Testing Set-ItResult" {
    It "This test should be inconclusive" {
        try {
            Set-ItResult -Inconclusive -Because "we are setting it to inconclusive"
        }
        catch {
            $_.FullyQualifiedErrorID | Should -Be "PesterTestInconclusive"
        }
    }

    It "This test should be skipped" {
        try {
            Set-ItResult -Skipped -Because "we are forcing it to skip"
        }
        catch {
            $_.FullyQualifiedErrorID | Should -Be "PesterTestSkipped"
        }
    }

    It "Set-ItResult appends the -Because reason to the message" {
        try {
            Set-ItResult -Skipped -Because "we are forcing it to skip"
        }
        catch {
            $_.Exception.Message | Should -Be "is skipped, because we are forcing it to skip"
        }
    }

    It "Set-ItResult can be called without -Because" {
        try {
            Set-ItResult -Skipped
        }
        catch {
            $_.FullyQualifiedErrorID | Should -Be "PesterTestSkipped"
        }
    }

    It "Set-ItResult has to have a switch indicating what to set it to" {
        { Set-ItResult -Because "testing with no switch" } | Should -Throw -Because "the expected state is not selected"
    }

    It "Set-ItResult cannot be called with two states requested" {
        { Set-ItResult -Inconclusive -Skipped } | Should -Throw -Because "two states are requested"
    }
}

