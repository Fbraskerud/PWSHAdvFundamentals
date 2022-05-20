Remove-Module -name #if something is loaded
Import-Module #which module you are checking

Run Tests | Debug tests
Describe  'Add-Courseuser'
BeforeAll {
    Mock -CommandName Set-Content -MockWith {
        Return 'Works!'
    }
}
    Context 'Verify Name' {
        it 'You Should be able to have the name '
    }
    