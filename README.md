# Get Commit Difference Count Between Two Branches Action

This Action returns the commit difference count between two branches, given their branch names.

## Inputs

### `base-branch`

**Required** The name of the first branch. Default `master`.

### `secondary-branch`

**Required** The name of the second branch. Default `development`.

## Outputs

### `commit-difference-count`

The number of commits between the base branch and the secondary branch.

## Example usage

    - name: Get Commit Difference Count Between Two Branches
          id: cdc
          uses: jessicalostinspace/commit-difference-action@v1.0.0
          with:
            base-branch: 'release-v1.2.3' 
            secondary-branch: 'master'
