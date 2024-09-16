class Solution {
public:
    int countNodes(TreeNode* root) {
        //we will just move to each node to count total nodes in that subtree
        if(root==NULL) return 0;
        
        //now since we are at a valid node we can count nodes using recursion
        //then no. of nodes = 1+ asknodes(leftsubtree) + asknodes(rightsubtree)
        return 1+countNodes(root->left) + countNodes(root->right);
    }
};
